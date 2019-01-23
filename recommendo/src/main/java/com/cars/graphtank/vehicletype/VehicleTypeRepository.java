package com.cars.graphtank.vehicletype;

import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.GraphRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by brendandite on 4/14/17.
 */
public interface VehicleTypeRepository extends GraphRepository<VehicleTypeNode> {

    VehicleTypeNode findByVehicleTypeId(Long vehicleTypeId);

    @Query("MATCH (vt:VehicleType)-[:OF_MAKE]->(m:Make) WHERE m.name = {makeName} RETURN vt")
    Iterable<VehicleTypeNode> findByMakeName(@Param(value = "makeName") String makeName);
}
