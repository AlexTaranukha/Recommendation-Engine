package com.cars.graphtank.make;

import org.springframework.data.neo4j.repository.GraphRepository;

/**
 * Created by brendandite on 4/14/17.
 */
public interface MakeRepository extends GraphRepository<MakeNode> {

    MakeNode findByName(String name);

    MakeNode findByMakeId(Long makeId);
}
