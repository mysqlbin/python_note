import yaml

if __name__ == "__main__":

   with open('yamls.yaml') as f:
      data = yaml.safe_load(f)
      print(data)

      """
      {'age': 37, 'spouse': {'name': 'Jane Smith', 'age': 25}, 'children': [{'name': 'Jimmy Smith', 'age': datetime.date(2020, 8, 11)}, {'name1': 'Jenny Smith ', 'age1': 12, 'age2': ['a', 'b', 'c']}]}
      """