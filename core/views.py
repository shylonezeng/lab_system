# Create your views here.
from django.shortcuts import render_to_response
from django.template.context import RequestContext

from core.models import Event


def index(request):
    # Obtain the context from the HTTP request.
    context = RequestContext(request)

    # Query the database for a list of ALL categories currently stored.
    # Order the categories by no. likes in descending order.
    # Retrieve the top 5 only - or all if less than 5.
    # Place the list in our context_dict dictionary which will be passed to the template engine.
    event_list = Event.objects.order_by('-likes')[:5]
    event_dict = {'events': event_list}

    # Render the response and send it back!
    return render_to_response('core_static/index.html',event_dict, context)