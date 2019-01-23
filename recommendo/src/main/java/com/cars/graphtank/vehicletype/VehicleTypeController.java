package com.cars.graphtank.vehicletype;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/20/17.
 */
@RestController
@RequestMapping("/vehicletypes")
public class VehicleTypeController {

    @Autowired
    private VehicleTypeService vehicleTypeService;

    @RequestMapping(method = RequestMethod.GET)
    public List<VehicleType> findAllVehicleTypes(@RequestParam(name = "makeName", required = false) String makeName) {
        if (StringUtils.isEmpty(makeName)) {
            return vehicleTypeService.findAllVehicleTypes();
        }
        return vehicleTypeService.findByMakeName(makeName);
    }

    @RequestMapping(value = "/{vehicleTypeId}", method = RequestMethod.GET)
    public VehicleType findByVehicleTypeId(@PathVariable Long vehicleTypeId) {
        notNull(vehicleTypeId, "Vehicle Type Id is required");
        return vehicleTypeService.findVehicleTypeById(vehicleTypeId);
    }
}
