package com.cars.graphtank.vehicletype;

import com.cars.graphtank.year.Year;
import com.cars.graphtank.year.YearNode;
import com.google.common.collect.Lists;

import java.util.List;

import static org.apache.commons.lang3.Validate.notEmpty;
import static org.apache.commons.lang3.Validate.notNull;

/**
 * Created by brendandite on 4/20/17.
 */
public class VehicleTypeService {

    VehicleTypeRepository vehicleTypeRepo;

    public VehicleTypeService(VehicleTypeRepository vehicleTypeRepo) {
        this.vehicleTypeRepo = notNull(vehicleTypeRepo, "Vehicle Type Repo is required");
    }

    public List<VehicleType> findAllVehicleTypes() {
        Iterable<VehicleTypeNode> nodes = vehicleTypeRepo.findAll();
        return flattenNodes(nodes);
    }

    public VehicleType findVehicleTypeById(Long vehicleTypeId) {
        notNull(vehicleTypeId, "Vehicle Type Id is required");
        return new VehicleType(vehicleTypeRepo.findByVehicleTypeId(vehicleTypeId));
    }

    public List<VehicleType> findByMakeName(String makeName) {
        notEmpty(makeName, "Make name is required");
        Iterable<VehicleTypeNode> nodes = vehicleTypeRepo.findByMakeName(makeName);
        return flattenNodes(nodes);
    }



    private List<VehicleType> flattenNodes(Iterable<VehicleTypeNode> vehicleTypeNodes) {
        notNull(vehicleTypeNodes, "Vehicle Type Nodes can not be null");
        List<VehicleType> vehicleTypes = Lists.newArrayList();
        for (VehicleTypeNode vehicleTypeNode : vehicleTypeNodes) {
            vehicleTypes.add(new VehicleType(vehicleTypeNode));
        }
        return vehicleTypes;
    }
}
