
# Create your views here.
from datetime import datetime
from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth.views import login, logout
from django.db import transaction
from django.http.response import HttpResponseRedirect, HttpResponse
from django.shortcuts import render_to_response, render
from django.template.context import RequestContext
from django.views.generic.list import ListView

from core.forms import BookForm
from core.models import Event, News, Borrow_item, Book
from lab_system.settings import min_datetime


@login_required
def restricted(request):
    return HttpResponse("Since you're logged in, you can see this text!")

def index(request,name="default"):
    # Obtain the context from the HTTP request.
    context = RequestContext(request)
    if request.user.is_authenticated():
         user=request.user
         context['current_user']=user
         getUserInfo(context, user)
    else:
        print("Debug:no active user")
    # Query the database for a list of ALL categories currently stored.
    # Order the categories by no. likes in descending order.
    # Retrieve the top 5 only - or all if less th200an 5.
    # Place the list in our context_dict dictionary which will be passed to the template engine.
    event_list = Event.objects.order_by('-etime')[:6]
  #  event_dict = {'events': event_list} 
    news_list=News.objects.all()
   # news_dict={'newss':news_list}
    
    context['events']=event_list
    context['newss']=news_list;
 
    # Render the response and send it back!
    return render_to_response('core_static/index.html',{},context)

def fillContextWithEventAndNew(context):
    event_list = Event.objects.order_by('-etime')[:6]
  #  event_dict = {'events': event_list}
    
    #get new dic
    news_list=News.objects.all()
 #   news_dict={'newss':news_list}
   
    context['events']=event_list;
    context['newss']=news_list;
   # context['username']=user.username
    return context
#
def getUserInfo(context,user):
        borrow_items=Borrow_item.objects.filter(user=user)
        context['current_user']=user
        not_returned=borrow_items.filter(return_time=min_datetime)
#         count=0;
#         for item in not_returned :
#             count+=1;
#             item.count=count
        context['not_returned']=not_returned
        context['returned']=borrow_items.exclude(return_time=min_datetime)

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
                
                fillContextWithEventAndNew(context)
                getUserInfo(context,user)
                
                return render_to_response('core_static/index.html',{},context)
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
 #  del request.session['current_user']
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
@login_required
@transaction.commit_on_success
def borrow(request):
    bookname=request.GET.get('book_name','')
    print("bookname %s"%bookname)
    context = RequestContext(request)
    normal_books=Book.objects.filter(status='normal')
    if bookname=='':
        #HttpResponse("book you wanna borrow not exist,please refer to system admin")
        context['usage']='not_borrowed_booklist'
        return render_to_response("core_static/book_list.html",{'books':normal_books},context)       
    else:
        print ("bookname not None")
        #add one borrowitem
        
        current_user=request.session.get('current_user')
        user=User.objects.get(username=current_user)
        book=None
        try:
            book=Book.objects.get(name=bookname,status='normal')
        except Exception as e: 
            return HttpResponse("no book existed which you wana borrow")
            
        borrowItem=Borrow_item(borrow_time=min_datetime)
        borrowItem.user=user
        borrowItem.book=book
        borrowItem.borrow_time=datetime.now()
        borrowItem.return_time=min_datetime       
      
        borrowItem.save()
        Book.objects.filter(name=bookname).update(status='borrowed')
        
        normal_books.exclude(status='borrowed')
        context['message']='borrowed succesfully'
     #   return HttpResponseRedirect('/core/index')
        return render_to_response("core_static/book_list.html",{'books':normal_books},context)
    
@login_required
@transaction.commit_on_success
def returnbook(request):
    bookname=request.GET.get('book_name','')
    bookset=Book.objects.filter(name=bookname)
    book_count=bookset.count()
    
    context=RequestContext(request)
    if book_count==0:
        #show all books not returned
        borrow_items=Borrow_item.objects.filter(user=request.user)
        #books_not_returned=Book.objects.select_related(user=request.user)
        books_not_returned = set([item.book for item in borrow_items])
        # books_not_returned=nr_items.book_set.all()
        context['usage']='borrowed_booklist'
        return render_to_response('core_static/book_list.html',{'books':books_not_returned},context)#('book you wanna return is loged, please ask system admin for help')
    
    #return borrowed book
    real_book=bookset[0]
    if real_book.status=='ordered':
        #send email to someone who order it 
        print('please send email to someone who order it ')
    bookset.update(status='normal')
    Borrow_item.objects.filter(book=real_book).update(return_time=datetime.now())
    return HttpResponseRedirect('/core/index/')
@login_required
@transaction.commit_on_success
def order(request):
    bookname=request.GET.get('book_name','')
    context = RequestContext(request)
    #get books can be reservedautoenv-1.0.0-py2.7.egg',
    #'/usr/local/lib/python2.7/dist-packages',

    borrow_items=Borrow_item.objects.filter(user=request.user)
    self_borrowed_books = set([item.book for item in borrow_items])
    other_borrowed_books=Book.objects.filter(status='borrowed')
    other_borrowed_books.exclude(self_borrowed_books)
  
    if bookname=='':
        #HttpResponse("book you wanna borrow not exist,please refer to system admin")
        context['usage']='other_borrowed_booklist'
    else:
        print("bookname %s"%bookname)
        Book.objects.filter(name=bookname).update(status='ordered')
        other_borrowed_books.exclude(name=bookname)#'book_name',''book_nameokname)
        context['message']='reserved for you succesfully'
     #   return HttpResponseRedirect('/core/index')
    return render_to_response("core_static/book_list.html",{'books':other_borrowed_books},context)

@login_required
@transaction.commit_on_success
def recommend(request):
    #bookname=request.GET.get('book_name','')
    # If it's a HTTP POST, we're interested in processing form data.
    context = RequestContext(request)
    if request.method == 'POST':
        bookform=BookForm(data=request.POST)
        print(bookform)
 #       bookform.status='recommend'
        if bookform.is_valid():
            book=bookform.save(commit=False)
            book_items=Book.objects.filter(name=book.name,author=book.author,publisher=book.publisher)
            book_items.filter(status='recommend')
            if book_items.count()> 1:
                return HttpResponse('failed to recommend because it has existed in laboratory')
            else:
                book=bookform.save()
             #  book.status='recommend'
                book.save()
                context['message']='recommend successfully'
                return render_to_response('core_static/recommend.html/',{'book':book},context)
        else: 
            context['message']="data invalid"
            return render_to_response('core_static/recommend.html/',context)
    else:
        #HttpResponseRedirect('/core/recommend/')
        context['message']=""
        return render_to_response("core_static/recommend.html", context)
    
