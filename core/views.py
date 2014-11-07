# Create your views here.
from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth.views import login, logout
from django.core.context_processors import request
from django.http.response import HttpResponseRedirect, HttpResponse
from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.views.generic.detail import DetailView
from django.views.generic.list import ListView

from core.models import Event, News, Book, Borrow_item, Book
from datetime import date, datetime


@login_required
def restricted(request):
    return HttpResponse("Since you're logged in, you can see this text!")

def index(request,name):
    # Obtain the context from the HTTP request.
    context = RequestContext(request)

    # Query the database for a list of ALL categories currently stored.
    # Order the categories by no. likes in descending order.
    # Retrieve the top 5 only - or all if less than 5.
    # Place the list in our context_dict dictionary which will be passed to the template engine.
    event_list = Event.objects.order_by('-etime')[:6]
    event_dict = {'events': event_list}
    
    #get new dic
    news_list=News.objects.all()
    news_dict={'newss':news_list}
    
    context['newss']=news_list;
    # Render the response and send it back!
    return render_to_response('core_static/index.html',event_dict,context)

def getContext(context):
    event_list = Event.objects.order_by('-etime')[:6]
  #  event_dict = {'events': event_list}
    
    #get new dic
    news_list=News.objects.all()
 #   news_dict={'newss':news_list}
   
    context['events']=event_list;
    context['newss']=news_list;
   # context['username']=user.username
    return context

def user_login(request):
    # Like before, obtain the context for the user's request.
    context = RequestContext(request)

    # If the request is a HTTP POST, try to pull out the relevant information.
    if request.method == 'POST':
        # Gather the username and password provided by the user.
        # This information is obtained from the login form.
        username = request.POST['username']
        password = request.POST['password']

        # Use Django's machinery to attempt to see if the username/password
        # combination is valid - a User object is returned if it is.
        user = authenticate(username=username, password=password)
        
        # If we have a User object, the details are correct.
        # If None (Python's way of representing the absence of a value), no user
        # with matching credentials was found.
        if user:
            # Is the account active? It could have been disabled.
            if user.is_active:
                # If the account is valid and active, we can log the user in.
                # We'll send the user back to the homepage.
                login(request, user)
                # get context and set username 
                current_user = request.session.get('current_user')
                if not current_user:
                    request.session['current_user'] = username
   
                getContext(context)
                context['username']=user.username
                return render_to_response('core_static/index.html', {}, context)
            else:
                # An inactive account was used - no logging in!
                return HttpResponse("Your account is disabled.")
        else:
            # Bad login details were provided. So we can't log the user in.
            print "Invalid login details: {0}, {1}".format(username, password)
            return HttpResponse("Invalid login details supplied.")

    # The request is not a HTTP POST, so display the login form.
    # This scenario would most likely be a HTTP GET.
    else:
        # No context variables to pass to the template system, hence the
        # blank dictionary object...
        return render_to_response('core_static/login.html', {}, context)
# Use the login_required() decorator to ensure only those logged in can access the view.

@login_required
def user_logout(request):
    # Since we know the user is logged in, we can now just log them out.
    logout(request)

    # Take the user back to the homepage.
    return HttpResponse('log out')
   # return HttpResponseRedirect('logout')

class IndexView(ListView):

    context_object_name = "Event_list"
    template_name='core_static/index.html'

    queryset = Event.objects.all()
    
    event_list = Event.objects.order_by('-etime')[:6]
    event_dict = {'events': event_list}
    
    #get new dic
    news_list=News.objects.all()
    news_dict={'newss':news_list}
    
    def get_context_object_name(self, object_list):
        return ListView.get_context_object_name(self, object_list)

# class EventDetailView(DetailView):
# 
#     context_object_name = 'Event_detail'
#     queryset = Event.objects.all()
#    # template_name='contacts/Events/Event_details.html'
# 
#     def get_context_data(self, **kwargs):
#         context = super(EventDetailView, self).get_context_data(**kwargs)
#         context['role'] = User.objects.all()
#         return context

# book manage 
def borrow(request,bookname):
    context = RequestContext(request)
    if bookname:
        normal_books=Book.objects.get(status='normal')           
        return render_to_response("/core/book_list.html",{'books',normal_books},context)
        #borrow
    else:
        Book.objects.filter(name='bookname').update(status='borrowed')
        #add one borrowitem
        
        current_user=request.session.get('current_user')
        user=User.objects.get(username=current_user)
        book=Book.objects.get(name=bookname)
        borrowItem=Borrow_item()
        borrowItem.user=user
        borrowItem.book=book
        borrowItem.borrow_time=datetime.now()
        borrowItem.return_time=None
        borrow.save()
        return  HttpResponse("borrowed succesfully");
    

def returnbook(request ,bookname):
    return
def order(request):
    return

def recommend(request): 
    return