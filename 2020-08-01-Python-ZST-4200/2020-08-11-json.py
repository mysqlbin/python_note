import json

if __name__ == "__main__":

   example_dict = {1: '6', 2: '2', 3: 'a'}
   with open("dict.json", "w") as f:
      json.dump(example_dict, f)
