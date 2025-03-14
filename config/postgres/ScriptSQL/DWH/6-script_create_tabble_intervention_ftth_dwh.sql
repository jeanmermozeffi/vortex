CREATE TABLE "fact_prise_charge_ftth" (
    "fact_prise_charge_ftth_id" SERIAL PRIMARY KEY NOT NULL,
    "client_id" INT NOT NULL,                      -- Identifiant du client (référence à `dim_client`)
    "incident_id" INT NOT NULL,                    -- Identifiant de l'incident (référence à `dim_incident`)
    "dim_temps_id" INT NOT NULL,                   -- Référence à la date (référence à `dim_temps`)
    "handling_time" FLOAT,                         -- Temps nécessaire pour traiter la prise en charge
    "sla_target" INT,                              -- SLA cible fixé pour la prise en charge
    "sla_met" BOOLEAN,                             -- Indicateur de respect du SLA (TRUE/FALSE)
    "charge_type" VARCHAR(50),                     -- Type de charge ("client" ou "incident")
    "sla_compliance_rate" FLOAT,                   -- Taux de respect du SLA (handling_time / sla_target)
    "sla_met_rate" FLOAT,                          -- Taux de respect du SLA (basé sur `sla_met` calculé pour les clients/incident)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,

    CONSTRAINT "fk_dim_client_fact_prise_charge" FOREIGN KEY ("client_id") REFERENCES "dim_client" ("client_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_incident_fact_prise_charge" FOREIGN KEY ("incident_id") REFERENCES "dim_incident" ("incident_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_prise_charge" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps" ("dim_temps_id") ON DELETE CASCADE
);

