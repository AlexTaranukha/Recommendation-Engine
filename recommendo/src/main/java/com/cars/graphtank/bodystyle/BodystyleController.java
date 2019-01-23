package com.cars.graphtank.bodystyle;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by brendandite on 4/21/17.
 */
@RestController
@RequestMapping("/bodystyles")
public class BodystyleController {

    @Autowired
    private BodystyleService bodystyleService;

    @RequestMapping(method = RequestMethod.GET)
    public List<Bodystyle> findAllBodystyles() {
        return bodystyleService.findAllBodystyles();
    }
}
