# Create your views here.
from datetime import datetime

from chartit.chartdata import DataPool
from chartit.charts import Chart
from django.contrib.auth import authenticate
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth.views import login, logout
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db import transaction
from django.http.response import HttpResponseRedirect, HttpResponse
from django.shortcuts import render_to_response, render
from django.template.context import RequestContext
from django.views.generic.list import ListView
from docutils.nodes import status

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
    event_list = Event.objects.filter(etime__gte=datetime.now()).order_by('etime')[:6]
  #  event_dict = {'events': event_list} 
    news_list=News.objects.all()[:6]
   # news_dict={'newss':news_list}
    
    context['events']=event_list
    context['newss']=news_list;
 
    # Render the response and send it back!
    return render_to_response('core_static/index.html',{},context)
#get top ones of all infomation
def fillContextWithEventAndNew(context):
    event_list = Event.objects.order_by('etime')[:6]
  #  event_dict = {'events': event_list}
    
    #get new dic
    news_list=News.objects.all()[:6]
 #   news_dict={'newss':news_list}
   
    context['events']=event_list;
    context['newss']=news_list;
   # context['username']=user.username
    return context
#
def getUserInfo(context,_user):
        print("getUserInfo user:%s"%_user)
        borrow_items=Borrow_item.objects.filter(user=_user)
        print("item count:%d"%borrow_items.count())
        context['current_user']=_user
        context['not_returned']=borrow_items.filter(return_time=min_datetime)[:6]
#         count=0;
#         for item in not_returned :
#             count+=1;
#             item.count=count
        #context['not_returned']=not_returned
        context['returned']=borrow_items.exclude(return_time=min_datetime)[:6]

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
    return HttpResponseRedirect('/core/index/')
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
        page = request.GET.get('page')
        paginator = Paginator(normal_books, 12) # Show 25 contacts per page
        try:
            normal_books= paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            normal_books= paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            normal_books= paginator.page(paginator.num_pages)
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
#     bookname=request.GET.get('book_name','')
#     bookset=Book.objects.filter(name=bookname)
#     book_count=bookset.count()

    borrowitem_id=request.GET.get('borrowitem_id','')
    page = request.GET.get('page')
    
    context=RequestContext(request)
    if borrowitem_id=='':
        #show all books not returned
        borrow_items=Borrow_item.objects.filter(user=request.user,return_time=min_datetime).order_by('-borrow_time')
#         context['borrow_items']=borrow_items;
        #books_not_returned=Book.objects.select_related(user=request.user)
        books_not_returned = set([item.book for item in borrow_items])
        
        paginator = Paginator(borrow_items, 12) # Show 25 contacts per page
        try:
            context['borrow_items']= paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            context['borrow_items']= paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            context['borrow_items']= paginator.page(paginator.num_pages)
        # books_not_returned=nr_items.book_set.all()
        context['usage']='borrowed_booklist'
        return render_to_response('core_static/book_list.html',{'books':books_not_returned},context)#('book you wanna return is loged, please ask system admin for help')
    
    #return borrowed book
    borrow_item=Borrow_item.objects.filter(id=borrowitem_id)
    borrow_item.update(return_time=datetime.now())
    real_book=borrow_item[0].book #Book.objects.get(id=borrow) set([ one_item.book for one_item in borrow_item])
    if real_book.status=='ordered':
        #send email to someone who order it 
        print('please send email to someone who order it ')
    Book.objects.filter(id=real_book.id).update(status='normal')
    return HttpResponseRedirect('/core/index/')
@login_required
@transaction.commit_on_success
def order(request):
    bookname=request.GET.get('book_name','')
    context = RequestContext(request)
    #get books can be reservedautoenv-1.0.0-py2.7.egg',
    #'/usr/local/lib/python2.7/dist-packages',

#     borrow_items=Borrow_item.objects.filter(user=request.user)
# #     self_borrowed_books = set([item.book for item in borrow_items])
#     self_borrowed_books_id = set([item.book.id for item in borrow_items])
#     other_borrowed_books=Book.objects.filter(status='borrowed')
#     other_borrowed_books=other_borrowed_books.exclude(id=self_borrowed_books_id)
#   
    borrowing_items=Borrow_item.objects.filter(return_time=min_datetime)
    print("order itmes:%d"%borrowing_items.count())
    other_borrowing_items=borrowing_items.exclude(user=request.user)
    print("order itmes:%d"%other_borrowing_items.count())
#     other_borrowing_books=set([item.book for item in other_borrowing_items])
    other_borrowing_books=Book.objects.filter(borrow_item__return_time=min_datetime,status="borrowed")
#    print("order itmes:%s"%other_borrowing_books)
    if bookname=='':
        #HttpResponse("book you wanna borrow not exist,please refer to system admin")
        context['usage']='other_borrowed_booklist'
    else:
        print("bookname %s"%bookname)
        other_borrowing_books.filter(name=bookname).update(status='ordered')
        other_borrowing_books=other_borrowing_books.filter(status='borrowed')
        context['message']='reserved for you succesfully'
     #   return HttpResponseRedirect('/core/index')

    return render_to_response("core_static/book_list.html",{'books':other_borrowing_books},context)

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
          #  book_items.filter(status='recommend')
            if book_items.count()>= 1:
                context['message']='failed to recommend because it has existed in laboratory, or has been recommended'
             #   return HttpResponse('failed to recommend because it has existed in laboratory')
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

def getNewsDetail(request):
    news_id=request.GET.get('news_id','')
    if news_id=='':
        return HttpResponse('erro request')
    news=News.objects.get(id=news_id)
    return render_to_response("core_static/news_detail.html",{'news':news})

@login_required
def getBorrowHistory(request):
#         _user=request.user
        context=RequestContext(request)
        borrow_items=Borrow_item.objects.filter(user=request.user)
#         context['current_user']=_user
#         context['not_returned']=borrow_items.filter(return_time=min_datetime)[:6]
#         count=0;
#         for item in not_returned :
#             count+=1;
#             item.count=count
#         context['not_returned']=not_returned
        returned_items=borrow_items.exclude(return_time=min_datetime).order_by('-return_time')
       
        paginator = Paginator(returned_items, 12) # Show 25 contacts per page
    
        page = request.GET.get('page')
        try:
            context['items']= paginator.page(page)
        except PageNotAnInteger:
            # If page is not an integer, deliver first page.
            context['items']= paginator.page(1)
        except EmptyPage:
            # If page is out of range (e.g. 9999), deliver last page of results.
            context['items']= paginator.page(paginator.num_pages)
        return render_to_response('core_static/borrow_history.html',context)            


# def monthname(month_num):
#       names ={1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun',
#               7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec'}
#       return names[month_num]
def showDataGraph(request):
    return HttpResponse("not completed")
#     ds = DataPool(
#        series=
#         [{'options': {
#             'source': MonthlyWeatherByCity.objects.all()},
#           'terms': [
#             'month',
#             'boston_temp']}
#          ])
# 
#   
#     
#     cht = Chart(
#             datasource = ds, 
#             series_options = 
#               [{'options':{
#                   'type': 'pie',
#                   'stacking': False},
#                 'terms':{
#                   'month': [
#                     'boston_temp']
#                   }}],
#             chart_options = 
#               {'title': {
#                    'text': 'Monthly Temperature of Boston'}},
#             x_sortf_mapf_mts = (None, monthname, False))
#     return  return render_to_response({'borrowchart.html': cht})

# for test TEMPLATE
def test(request):
    return render_to_response('core_static/bases/detail_base.html')
