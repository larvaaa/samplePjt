package front.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/shopping")
public class ItemController {
	
	@RequestMapping(value = "/add/item", method=RequestMethod.GET)
	public String moveItemForm() {
		return "/front/shopping/item/register";
	}

}
