from django.conf.urls import url
from sign import views_if

app_name = "sign"
urlpatterns = [
	#guest system interface
	#ex : /api/add_event/
	url(r'^add_event/', views_if.add_event, name='add_event'),
	#ex : /apt/add_guest
	url(r'^add_guest/', views_if.add_guest, name='add_guest'),
	#ex : /api/get_event_list
	url(r'^get_event_list/', views_if.get_event_list, name='get_event_list'),
	#ex : /api/get_guest_list
	url(r'^get_guest_list/', views_if.get_guest_list, name='get_guest_list'),
	#ex : /api/change_guest
	url(r'^change_guest/', views_if.change_guest, name='change_guest'),
	#ex : /api/delete_guest
	url(r'^delete_guest/', views_if.delete_guest, name='delete_guest'),
	#ex : /api/user_sign
	url(r'^user_sign/', views_if.user_sign, name='user_sign'),
]