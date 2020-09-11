from django import forms
from django.core.validators import RegexValidator

def username_validate(value):
    if value == "admin":
        raise forms.ValidationError("用户名非法")

def password_validate(value):
    if value == "123456":
        raise forms.ValidationError("您输入的密码太简单")

class RegisterForm(forms.Form):
    username = forms.CharField(max_length=64, required=True, validators=[username_validate, ])
    password = forms.CharField(widget=forms.PasswordInput(), required=True, validators=[RegexValidator(r'^\w{6,16}', '密码由6-16位的数字和字母组成')])
    # password = forms.CharField(widget=forms.PasswordInput(), required=True, validators=[password_validate, ])
    email = forms.EmailField()

    # def clean_password(self):
    #     password = self.cleaned_data.get('password')
    #     if password == "123456":
    #         raise forms.ValidationError(message="密码太简单了")
    #     return password