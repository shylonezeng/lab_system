from django.conf.urls import patterns, include, url
from django.contrib import admin

from core import views
import core.urls


# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'lab_system.views.home', name='home'),
    # url(r'^lab_system/', include('core.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^core/',include(core.urls)),
   # url(r'^$',views.test,name='test'),
    url(r'^accounts/login/$', views.user_login, name='login'),
        
)
