package front.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WeightCalendarController {

	private static final Logger logger = LoggerFactory.getLogger(WeightCalendarController.class);
	
	@RequestMapping(value="/goWeightCal", method=RequestMethod.GET)
	public ModelAndView main(HttpServletRequest req, HttpServletResponse res) {
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("weightCalendar");
		
		return mav;
		
	}

}
