import json
import difflib

def Word_Definition(r,data):
	r=r.lower()
	if r in data.keys():
			return data.get(r)
	else:
			print("Definition not found");  
			found_match=difflib.get_close_matches(r,data.keys());
			print("Did you mean",found_match)
			user=input("Y/N:")
			user=user.lower()
			if user=="y":
				word=input("Input new word:");
				return Word_Definition(word,data)
			else:
				return("Word could not be found in dictionary")
		
		
data=json.load(open("data.json"))
word=input("Enter a word:")
definition=Word_Definition(word,data)
if type(definition)==list
	for item in definition
		print(item)



