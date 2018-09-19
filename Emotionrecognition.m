function varargout = Emotionrecognition(varargin)
% EMOTIONRECOGNITION MATLAB code for Emotionrecognition.fig
%      EMOTIONRECOGNITION, by itself, creates a new EMOTIONRECOGNITION or raises the existing
%      singleton*.
%
%      H = EMOTIONRECOGNITION returns the handle to a new EMOTIONRECOGNITION or the handle to
%      the existing singleton*.
%
%      EMOTIONRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMOTIONRECOGNITION.M with the given input arguments.
%
%      EMOTIONRECOGNITION('Property','Value',...) creates a new EMOTIONRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Emotionrecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Emotionrecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Emotionrecognition

% Last Modified by GUIDE v2.5 17-May-2017 14:10:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Emotionrecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @Emotionrecognition_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Emotionrecognition is made visible.
function Emotionrecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Emotionrecognition (see VARARGIN)

% Choose default command line output for Emotionrecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Emotionrecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Emotionrecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);
[filename,pathname] = uigetfile({'*.wav';'*mp3'},'Select File');
handles.file=[pathname filename];
handles.pathname=pathname;
handles.filename=filename;
[Test_M]=class_Test([pathname filename]);
[x,fs] = audioread([pathname filename]);
myGui.freqSam=fs;
myGui.datasound=x;
myGui.player=audioplayer(myGui.datasound,myGui.freqSam);
myGui.flag=2;
set(handles.text6,'String',[pathname filename]);
guidata(handles.figure1,myGui)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);
if(myGui.flag==2)
    myGui.flag=1;
    disp('2');
    play(myGui.player);
else
    if(myGui.flag == 1)
        disp('1');
        myGui.flag=0;
        pause(myGui.player);
    else
        disp('0');
        myGui.flag=1;
        resume(myGui.player)
    end
end
guidata(handles.figure1,myGui);


% --- Executes on button press in Classify.
function Classify_Callback(hObject, eventdata, handles)
% hObject    handle to Classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% musicfilename=get(handles.text6,'String');
TT=evalin('base','TT');
Test_M=evalin('base','Test_M');
 run KnnClassify(TT,Test_M,21);
f=fopen('C:\Users\matthew\Documents\MATLAB\Built emotion recognition\classification.txt');
s=fscanf(f,'%s ');
fclose(f);
set(handles.text4,'String',s);
