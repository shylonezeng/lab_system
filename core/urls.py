from django.conf.urls import patterns, url

from core import views
from core.models import Event
from core.views import IndexView


event_detail_info = {
    "queryset": Event.objects.all(),
}

urlpatterns = patterns('',
        url(r'^(index/$|$)', views.index, name='index'),
      #  url(r'^event/$', EventListView.as_view()),
        url(r'^event/$', IndexView.as_view(), ),
        url(r'^login/$', views.user_login, name='login'),
        url(r'^restricted/$', views.restricted, name='restricted'),
        url(r'^logout/$', views.user_logout, name='logout'),
        url(r'^borrow/$', views.borrow, name='borrow'),
        url(r'^borrow/(?P<book_name>)$', views.borrow, name='borrow'),
        url(r'^return/$', views.returnbook, name='return'),
        url(r'^order/$', views.order, name='order'),
        url(r'^recommend/$', views.recommend, name='recommend'),
        )
