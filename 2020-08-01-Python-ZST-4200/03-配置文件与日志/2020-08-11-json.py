import json

if __name__ == "__main__":

   example_dict = {1: '6', 2: '2', 3: 'a'}
   print('type: {}'.format(type(example_dict)))

   json_str = json.dumps(example_dict)
   print('type: {}, content:{}'.format(type(json_str), json_str))

   de_json = json.loads(json_str)
   print('type: {}, content:{}'.format(type(de_json), de_json))

   with open("dict.json", "w") as f:
      json.dump(example_dict, f)
