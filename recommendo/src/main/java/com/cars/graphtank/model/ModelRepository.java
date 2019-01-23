package com.cars.graphtank.model;

import org.springframework.data.neo4j.repository.GraphRepository;

/**
 * Created by brendandite on 4/14/17.
 */
public interface ModelRepository extends GraphRepository<ModelNode> {
}
