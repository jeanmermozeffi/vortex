CREATE TABLE "dim_kpi" (
    "dim_kpi_id" SERIAL PRIMARY KEY NOT NULL,   -- Identifiant du KPI
    "kpi_name" VARCHAR(255) NOT NULL,           -- Nom du KPI
    "kpi_type" VARCHAR(100) NOT NULL,           -- Ex: "Taux", "Délai", "Nombre", etc.
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN
);

CREATE TABLE "fact_refonte_kpi" (
    "fact_refonte_kpi_id" SERIAL PRIMARY KEY NOT NULL,
    "kpi_id" INT,                    -- Identifiant du KPI (référence à "dim_kpi")
    "dim_temps_id" INT NOT NULL,              -- Référence à la date (référence à "dim_time")
    "kpi_redesigned" INT,            -- Nombre de KPI redéfinis
    "kpi_total" INT,                 -- Nombre total de KPI
    "refonte_rate" FLOAT,           -- Taux de refonte des KPI (kpi_redesigned / kpi_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_kpi" FOREIGN KEY ("kpi_id") REFERENCES "dim_kpi"("dim_kpi_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_taux_cloture_projets" (
    "fact_taux_cloture_projets_id" SERIAL PRIMARY KEY NOT NULL,
    "projet_id" INT NOT NULL,               -- Identifiant du projet (référence à "dim_projet")
    "dim_temps_id" INT NOT NULL,            -- Référence à la date de clôture du projet (référence à "dim_time")
    "projets_clotures" INT,        -- Nombre de projets clôturés
    "projets_total" INT,           -- Nombre total de projets reçus
    "closure_rate" FLOAT,          -- Taux de clôture des projets (projets_clotures / projets_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet" FOREIGN KEY ("projet_id") REFERENCES "dim_projet"("projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_taux_prise_charge_projets" (
    "fact_taux_prise_charge_projets_id" SERIAL PRIMARY KEY NOT NULL,
    "projet_id" INT NOT NULL,       -- Identifiant du projet (référence à "dim_projet")
    "dim_temps_id" INT NOT NULL,             -- Référence à la date de prise en charge du projet (référence à "dim_time")
    "projets_pris_en_charge" INT,   -- Nombre de projets pris en charge
    "projets_total" INT,            -- Nombre total de projets reçus
    "handling_rate" FLOAT,          -- Taux de prise en charge des projets (projets_pris_en_charge / projets_total)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_taux_prise_charge_projets" FOREIGN KEY ("projet_id") REFERENCES "dim_projet"("projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_taux_prise_charge_projets" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_transmission_delay" (
    "fact_transmission_delay_id" SERIAL PRIMARY KEY NOT NULL,
    "projet_id" INT NOT NULL,      -- Identifiant du projet (référence à "dim_projet")
    "dim_temps_id" INT NOT NULL,   -- Référence à la date de mise en œuvre, de réalisation ou de transmission (référence à "dim_time")
    "time_type" VARCHAR(50),       -- Type de délai ("implementation_time", "realisation_time", "report_transmission_time", "document_transmission_time")
    "time_value" FLOAT,            -- Temps de mise en œuvre, de réalisation ou de transmission (en heures)
    "sla_target" INT,              -- SLA cible fixé pour la mise en œuvre, la réalisation ou la transmission
    "sla_met" BOOLEAN,             -- Indicateur si le SLA a été respecté (Vrai/Faux)
    "rate" FLOAT,                  -- Taux calculé (par exemple, respect des délais)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_projet_fact_taux_prise_charge_projets" FOREIGN KEY ("projet_id") REFERENCES "dim_projet"("projet_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_taux_prise_charge_projets" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_time"("dim_temps_id") ON DELETE CASCADE
);

