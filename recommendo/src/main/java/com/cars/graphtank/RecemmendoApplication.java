package com.cars.graphtank;

import com.cars.graphtank.bodystyle.BodystyleRepository;
import com.cars.graphtank.bodystyle.BodystyleService;
import com.cars.graphtank.make.MakeNode;
import com.cars.graphtank.make.MakeRepository;
import com.cars.graphtank.make.MakeService;
import com.cars.graphtank.model.ModelNode;
import com.cars.graphtank.model.ModelRepository;
import com.cars.graphtank.trim.TrimNode;
import com.cars.graphtank.trim.TrimRepository;
import com.cars.graphtank.vehicletype.VehicleTypeNode;
import com.cars.graphtank.vehicletype.VehicleTypeRepository;
import com.cars.graphtank.vehicletype.VehicleTypeService;
import com.cars.graphtank.year.YearNode;
import com.cars.graphtank.year.YearRepository;
import com.cars.graphtank.year.YearService;
import org.neo4j.ogm.config.Configuration;
import org.neo4j.ogm.session.SessionFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.neo4j.repository.config.EnableNeo4jRepositories;
import org.springframework.data.neo4j.transaction.Neo4jTransactionManager;

@SpringBootApplication
@EnableNeo4jRepositories
public class RecemmendoApplication {

    public static void main(String[] args) {
        SpringApplication.run(RecemmendoApplication.class, args);
    }

	@Bean
	public Configuration getConfiguration() {
		Configuration config = new Configuration();
		config.driverConfiguration()
				.setDriverClassName("org.neo4j.ogm.drivers.http.driver.HttpDriver")
				.setURI("http://ec2-54-214-3-158.us-west-2.compute.amazonaws.com:7474")
				.setCredentials("neo4j", "graphtank");
		return config;

		// Browser - http://ec2-54-244-185-38.us-west-2.compute.amazonaws.com:7474
	}

	@Bean
	public SessionFactory sessionFactory() {
		return new SessionFactory(getConfiguration(), "com.cars.graphtank");
	}

    @Bean
    public Neo4jTransactionManager transactionManager() {
        return new Neo4jTransactionManager(sessionFactory());
    }


    @Bean
    CommandLineRunner demo(MakeRepository makeRepo, ModelRepository modelRepo, TrimRepository trimRepo,
                           YearRepository yearRepo, VehicleTypeRepository vehicleTypeRepo) {
        return args -> {
//            modelRepo.deleteAll();
//            trimRepo.deleteAll();
//            yearRepo.deleteAll();
//            makeRepo.deleteAll();
//            vehicleTypeRepo.deleteAll();
//            MakeNode ford = new MakeNode(12345L, "Ford");
//            MakeNode toyota = new MakeNode(23456L, "Toyota");
//            makeRepo.save(ford);
//            makeRepo.save(toyota);
//            YearNode twenty14 = new YearNode(12345L, 2014);
//            YearNode twenty15 = new YearNode(23456L, 2015);
//            YearNode twenty16 = new YearNode(34567L, 2016);
//            YearNode twenty17 = new YearNode(45678L, 2017);
//            ford.setYears(null);
//            ford.addYear(twenty14);
//            ford.addYear(twenty15);
//            ford.addYear(twenty16);
//            ford.addYear(twenty17);
//            makeRepo.save(ford);
//            toyota.addYear(twenty14);
//            toyota.addYear(twenty15);
//            toyota.addYear(twenty16);
//            toyota.addYear(twenty17);
//            makeRepo.save(ford);
//
//            ModelNode pinto = new ModelNode(23456L, "Pinto", ford);
//            pinto.addYear(twenty14);
//            pinto.addYear(twenty15);
//            pinto.addYear(twenty16);
//            ModelNode taurus = new ModelNode(34567L, "Taurus", ford);
//            taurus.addYear(twenty14);
//            taurus.addYear(twenty15);
//            taurus.addYear(twenty16);
//            taurus.addYear(twenty17);
//            ModelNode explorer = new ModelNode(45678L, "Explorer", ford);
//            explorer.addYear(twenty16);
//            explorer.addYear(twenty17);
//            ModelNode corolla = new ModelNode(56789L, "Corolla", toyota);
//            corolla.addYear(twenty14);
//            corolla.addYear(twenty15);
//            corolla.addYear(twenty16);
//            corolla.addYear(twenty17);
//            ModelNode camry = new ModelNode(67890L, "Camry", toyota);
//            camry.addYear(twenty14);
//            camry.addYear(twenty15);
//            camry.addYear(twenty16);
//            camry.addYear(twenty17);
//            modelRepo.save(pinto);
//            modelRepo.save(taurus);
//            modelRepo.save(explorer);
//            modelRepo.save(corolla);
//            modelRepo.save(camry);
//
//            TrimNode xl = new TrimNode(12345L, "XL", pinto);
//            xl.addYear(twenty14);
//            xl.addYear(twenty15);
//            xl.addYear(twenty16);
//            TrimNode xs = new TrimNode(23456L, "XS", pinto);
//            xs.addYear(twenty16);
//            trimRepo.save(xl);
//            trimRepo.save(xs);
//            TrimNode limited = new TrimNode(34567L, "Limited", explorer);
//            TrimNode unlimited = new TrimNode(45678L, "Unlimited", explorer);
//            limited.addYear(twenty16);
//            limited.addYear(twenty17);
//            unlimited.addYear(twenty16);
//            unlimited.addYear(twenty17);
//            trimRepo.save(limited);
//            trimRepo.save(unlimited);
//            TrimNode boring = new TrimNode(56789L, "Boring", taurus);
//            boring.addYear(twenty14);
//            boring.addYear(twenty15);
//            TrimNode fauxLux = new TrimNode(67890L, "Faux Luxury", taurus);
//            fauxLux.addYear(twenty15);
//            fauxLux.addYear(twenty16);
//            fauxLux.addYear(twenty17);
//            TrimNode xt = new TrimNode(78901L, "XT", taurus);
//            xt.addYear(twenty14);
//            xt.addYear(twenty15);
//            xt.addYear(twenty16);
//            xt.addYear(twenty17);
//            trimRepo.save(boring);
//            trimRepo.save(fauxLux);
//            trimRepo.save(xt);
//            TrimNode lt = new TrimNode(89012L, "LT", corolla);
//            lt.addYear(twenty14);
//            lt.addYear(twenty15);
//            lt.addYear(twenty16);
//            lt.addYear(twenty17);
//            TrimNode mt = new TrimNode(90123L, "MT", corolla);
//            mt.addYear(twenty14);
//            mt.addYear(twenty15);
//            mt.addYear(twenty16);
//            mt.addYear(twenty17);
//            trimRepo.save(lt);
//            trimRepo.save(mt);
//            TrimNode sport = new TrimNode(24680L, "Sport", camry);
//            sport.addYear(twenty14);
//            sport.addYear(twenty15);
//            sport.addYear(twenty16);
//            sport.addYear(twenty17);
//            TrimNode rugged = new TrimNode(46802L, "Rugged", camry);
//            rugged.addYear(twenty14);
//            rugged.addYear(twenty15);
//            rugged.addYear(twenty16);
//            trimRepo.save(sport);
//            trimRepo.save(rugged);
//
//            VehicleTypeNode fordTaurusFL17 = new VehicleTypeNode(12345L, ford, taurus, fauxLux, twenty17);
//            VehicleTypeNode fordTaurusFL16 = new VehicleTypeNode(23456L, ford, taurus, fauxLux, twenty16);
//            VehicleTypeNode fordTaurusFL15 = new VehicleTypeNode(34567L, ford, taurus, fauxLux, twenty15);
//            VehicleTypeNode toyotaCorollaLT17 = new VehicleTypeNode(45678L, toyota, corolla, lt, twenty17);
//            VehicleTypeNode toyotaCorollaLT16 = new VehicleTypeNode(56789L, toyota, corolla, lt, twenty16);
//            VehicleTypeNode toyotaCorollaLT15 = new VehicleTypeNode(67890L, toyota, corolla, lt, twenty15);
//            VehicleTypeNode toyotaCorollaLT14 = new VehicleTypeNode(78901L, toyota, corolla, lt, twenty14);
//            vehicleTypeRepo.save(fordTaurusFL15);
//            vehicleTypeRepo.save(fordTaurusFL16);
//            vehicleTypeRepo.save(fordTaurusFL17);
//            vehicleTypeRepo.save(toyotaCorollaLT14);
//            vehicleTypeRepo.save(toyotaCorollaLT15);
//            vehicleTypeRepo.save(toyotaCorollaLT16);
//            vehicleTypeRepo.save(toyotaCorollaLT17);
        };
    }

    @Bean
    public YearService yearService(YearRepository yearRepository) {
        return new YearService(yearRepository);
    }

    @Bean
    public MakeService makeService(MakeRepository makeRepo) {
        return new MakeService(makeRepo);
    }

    @Bean
    public VehicleTypeService vehicleTypeService(VehicleTypeRepository vehicleTypeRepository) {
        return new VehicleTypeService(vehicleTypeRepository);
    }

    @Bean
    public BodystyleService bodystyleService(BodystyleRepository bodystyleRepository) {
        return new BodystyleService(bodystyleRepository);
    }


}
