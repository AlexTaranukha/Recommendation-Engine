package com.cars.graphtank.make;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by brendandite on 4/14/17.
 */
@RestController
@RequestMapping(value="/makes")
public class MakeController {

    @Autowired
    private MakeService makeService;

    @RequestMapping(value="/{id}", method = RequestMethod.GET)
    public Make findOneMake(@PathVariable Long id) {
        return makeService.findByMakeId(id);
    }

    @RequestMapping(method = RequestMethod.GET)
    public List<Make> findAllMake() {
        return makeService.findAllMakes();
    }


}
