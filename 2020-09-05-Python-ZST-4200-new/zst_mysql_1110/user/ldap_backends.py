
import ldap
from django.conf import settings
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User

class LdapBackend:

    def authenticate(self, request, username=None, password=None, **kwargs):
        # return '1'
        try:
            # con = ldap.initialize('ldap://127.0.0.1:10389')
            # con.simple_bind_s('uid=admin,ou=system', 'secret')
            # results = con.search_s('dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)
            # results = con.search_s('o=zst_k8s,dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)

            con = ldap.initialize(settings.ZST_LDAP_HOST)
            con.simple_bind_s(settings.ZST_LDAP_ADMIN_BIND_DN, settings.ZST_LDAP_ADMIN_PASSWD)
            results = con.search_s('dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)

            if results is not None and len(results) == 1:
                user = results[0]
                user_dn = user[0]
                con.simple_bind_s(user_dn, password)

                user_model = get_user_model()
                try:
                    u = user_model.objects.get(username=username)
                    need_save = False
                except user_model.DoesNotExist:
                    u = user_model(username=username)
                    need_save = True

                if need_save:
                    u.save()

                return u

            else:
                return None

            return None

        except ldap.LDAPError as e:

            return None

    # 这段代码的作用是什么
    def get_user(self, user_id):
        user_model = get_user_model()
        try:
            return user_model.objects.get(pk=user_id)
        except user_model.DoesNotExist:
            return None
    '''
    try:
        con = ldap.initialize('ldap://127.0.0.1:10389')
        username = "apple"
        password = "123456abc"

        # 验证管理员账号admin的密码
        con.simple_bind_s('uid=admin,ou=system', 'secret')

        results = con.search_s('dc=example,dc=com', ldap.SCOPE_SUBTREE, "uid=%s" % username)
        if results is not None and len(results) == 1:
            user = results[0]
            user_dn = user[0]
            con.simple_bind_s(user_dn, password)
        else:
            return HttpResponse('user not exists')
        return HttpResponse('login success')

    except ldap.LDAPError as e:

        return HttpResponse('login failed', str(e))
        return HttpResponse("success")

    except ldap.LDAPError as e:
        return HttpResponse("failed")
    '''