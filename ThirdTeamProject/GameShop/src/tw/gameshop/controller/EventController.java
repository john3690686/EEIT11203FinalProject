package tw.gameshop.controller;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.eclipse.jdt.internal.compiler.util.Sorting;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;


import tw.gameshop.user.model.Game_EventService;
import tw.gameshop.user.model.Product;
import tw.gameshop.user.model.Comment;
import tw.gameshop.user.model.Game_Event;

@Controller
public class EventController {

	private Game_EventService eventService;

	@Autowired
	public EventController(Game_EventService eventService) {
		this.eventService = eventService;
	}
	
	@RequestMapping(path = "/processHomePage",method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	
	@RequestMapping(path = "/processShowEvent",method = RequestMethod.GET)
	public String Event() {
		return "ShowEvent";
	}
	
	@RequestMapping(path = "/processEvent",method = RequestMethod.GET)
	public String goTestTabs() {
		return "EventPage";
	}
	
	@RequestMapping(path = "/addEvent",method = RequestMethod.POST)
	public String addEvent(@RequestParam("productId")int productId,@RequestParam("startDate")String startDate, 
			@RequestParam("eventName")String eventName,@RequestParam("content")String content,
			@RequestParam("endDate")String endDate,@RequestParam("eventImage")MultipartFile eventImage)  {				
		try {
			if(eventService.queryAllEvent()!= null) {
				Game_Event event = new Game_Event();							
				event.setContent(content);
				event.setEventName(eventName);
				event.setProductId(productId);
				event.setStartDate(startDate);
				event.setEndDate(endDate);
				event.setEventImage(eventImage.getBytes());
				eventService.addEvent(event);
			}
				System.out.println("add Data Success!");
		}catch(Exception e) {
			e.printStackTrace();
		}	
		return "redirect:/processEvent";
	}
	
	
	@ResponseBody
	@RequestMapping(path = "/queryAllEvent",method = RequestMethod.GET )
	public List<Game_Event> queryAllData() {
		List<Game_Event> eventList = eventService.queryAllEvent2();
		System.out.println("start queryAllEvent controller");
		return eventList;
	}
	
	
	@ResponseBody
	@RequestMapping(path = "/deleteEvent",method = RequestMethod.POST)
	public String deleteEvent(int eventId) {
		
		try {
			eventService.deleteEvent(eventId);
			Game_Event q1 = eventService.queryEvent(eventId);
			if(q1 == null) {
				System.out.println("data delete success!");
			}else {
				System.out.println("data delete false!");
			}			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("Error:event_controller");
		}
		return "ok";		
	}

	
	@RequestMapping(path = "/queryEvent",method = RequestMethod.GET)
	@ResponseBody
	public Game_Event queryData(int eventId) {
		Game_Event event = eventService.queryEvent(eventId);
		
		return event;
		
	}
	
	// to event
	@RequestMapping(path="/Event",method = RequestMethod.GET)
	public String toEventPage2() {
		return "Event";
	}
	
	// use id to find event and show it
		@RequestMapping(path="/searchEvent{urlname}", method=RequestMethod.GET)
		public String findEventById(@ModelAttribute("searchGo")Game_Event myEvent, 
		@PathVariable("urlname")String urlName, BindingResult result, ModelMap model) throws IOException{
					
				urlName = String.valueOf(myEvent.getEventId());
				
				model.addAttribute("eventId", myEvent.getEventId());
				model.addAttribute("eventName", myEvent.getEventName());
				model.addAttribute("eventContent", myEvent.getContent());
				model.addAttribute("sDate", myEvent.getStartDate());
				model.addAttribute("eDate", myEvent.getEndDate());
				
				return "showEventResult";
}	
	
	@RequestMapping(path = "/updateEvent",method = RequestMethod.POST)
	public String updateEvent(@RequestParam("productId1")int productId,@RequestParam("startDate1")String startDate, 
			@RequestParam("eventName1")String eventName,@RequestParam("content1")String content,
			@RequestParam("endDate1")String endDate,@RequestParam("eventImage1")MultipartFile eventImage,@RequestParam("eventId1")int eventId) throws IOException  {				
		
		System.out.println("updateEvent_ControllerStart");	
		//System.out.println(content.substring(1));
		System.out.println("eventImage:"+eventImage);
		System.out.println("eventImage.getBytes:"+eventImage.getBytes());
		Game_Event gEvent = new Game_Event();
		gEvent.setStartDate(startDate);
		gEvent.setEndDate(endDate);		
		gEvent.setProductId(productId);
		gEvent.setContent(content.substring(1));
		gEvent.setEventName(eventName);
		if(eventImage != null) {
			gEvent.setEventImage(eventImage.getBytes());
		}	
		eventService.upDateEvent(eventId, gEvent);
		
		return "EventPage";
	}

}
