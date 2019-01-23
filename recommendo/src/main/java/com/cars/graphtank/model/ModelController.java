package com.cars.graphtank.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by brendandite on 4/14/17.
 */
@RestController
@RequestMapping(value = "/models")
public class ModelController {

    @Autowired
    ModelRepository modelRepo;

    @RequestMapping(method = RequestMethod.GET)
    public Iterable<ModelNode> findAllModels() {
        return modelRepo.findAll();
    }
}
