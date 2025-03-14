CREATE TABLE "fact_taux_completion_etudes"
(
    "fact_taux_completion_etudes_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_etude_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "etudes_realisees" INT,
    "etudes_planifiees" INT,
    "completion_rate" FLOAT,      -- Taux de completion des études (etudes_realisees / etudes_planifiees)
    "rate" FLOAT,                 -- Taux calculé de completion des études
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_etude_fact_taux_completion_etudes" FOREIGN KEY ("dim_etude_id") REFERENCES "dim_etude"("dim_etude_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_taux_completion_etudes" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_taux_validation_etudes"
(
    "fact_taux_validation_etudes_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_etude_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "etudes_validees" INT,
    "etudes_soumises" INT,
    "validation_rate" FLOAT,       -- Taux de validation des études (etudes_validees / etudes_soumises)
    "rate" FLOAT,                  -- Taux calculé de validation des études
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_etude_fact_taux_validation_etudes" FOREIGN KEY ("dim_etude_id") REFERENCES "dim_etude"("dim_etude_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_taux_validation_etudes" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_taux_resolution_incidents"
(
    "fact_taux_resolution_incidents_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_incident_id" INT,
    "dim_temps_id" INT NOT NULL,
    "incidents_resolus" INT,
    "incidents_total" INT,
    "resolution_rate" FLOAT,       -- Taux de résolution des incidents (incidents_resolus / incidents_total)
    "rate" FLOAT,                  -- Taux calculé de résolution des incidents
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_incident_fact_taux_resolution_incidents" FOREIGN KEY ("dim_incident_id") REFERENCES "dim_incident"("dim_incident_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_taux_resolution_incidents" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_taux_centralisation_documentaire"
(
    "fact_taux_centralisation_documentaire_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_projet_id" INT,
    "dim_temps_id" INT NOT NULL,
    "projets_centralises" INT,
    "projets_total" INT,
    "centralisation_rate" FLOAT,  -- Taux de centralisation des documents (projets_centralises / projets_total)
    "rate" FLOAT,                 -- Taux calculé de centralisation des documents
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_taux_centralisation_documentaire" FOREIGN KEY ("dim_projet_id") REFERENCES "dim_projet"("dim_projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_taux_centralisation_documentaire" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_satisfaction_client"
(
    "fact_satisfaction_client_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_client_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "reponses_satisfaites" INT,
    "sondages_total" INT,
    "satisfaction_rate" FLOAT,    -- Taux de satisfaction des clients (reponses_satisfaites / sondages_total)
    "rate" FLOAT,                 -- Taux calculé de satisfaction client
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_client_fact_satisfaction_client" FOREIGN KEY ("dim_client_id") REFERENCES "dim_client"("dim_client_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_satisfaction_client" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_nps"
(
    "fact_nps_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_client_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "promoteurs" INT,
    "detractors" INT,
    "nps" FLOAT,                  -- NPS (Net Promoter Score) = (promoteurs - detractors) / sondages_total
    "rate" FLOAT,                 -- Taux calculé de NPS
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_client_fact_nps" FOREIGN KEY ("dim_client_id") REFERENCES "dim_client"("dim_client_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_nps" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_suivi_reclamations"
(
    "fact_suivi_reclamations_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_client_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "clients_sans_reclamation" INT,
    "clients_total" INT,
    "reclamation_rate" FLOAT,    -- Taux de réclamation des clients (clients_sans_reclamation / clients_total)
    "rate" FLOAT,                -- Taux calculé de réclamation
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_client_fact_suivi_reclamations" FOREIGN KEY ("dim_client_id") REFERENCES "dim_client"("dim_client_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_suivi_reclamations" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

