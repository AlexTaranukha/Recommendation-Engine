package com.cars.graphtank.year;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by brendandite on 4/20/17.
 */
@RestController
@RequestMapping(value = "/years")
public class YearController {

    @Autowired
    YearService yearService;

    @RequestMapping(method = RequestMethod.GET)
    public List<Year> findAllYears() {
        return yearService.findAllYears();
    }
}
