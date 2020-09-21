import re

print("a\b")
print(r"a\b")
print("\n")
print(r"\n")
print("\\")
print(r"\\")

# \\ 匹配斜杠本身
pattern = re.compile(r"\\")
m = pattern.match("\\")
if m:
    print(m.group())
else:
    print("not match")
