CREATE TABLE "fact_performance_taches"
(
    "fact_performance_taches_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_tache_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "tasks_received" INT,
    "tasks_handled" INT,
    "handling_rate" FLOAT,
    "tasks_completed_on_time" INT,
    "tasks_total" INT,
    "on_time_rate" FLOAT,
    "coordination_time" FLOAT,
    "sla_met" BOOLEAN,
    "target_time" FLOAT,
    "sla_compliance_rate" FLOAT,         -- Ajout du taux de respect du SLA
    "total_tasks" INT,                  -- Somme de tasks_received + tasks_handled
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_tache_fact_performance_taches" FOREIGN KEY ("dim_tache_id") REFERENCES "dim_tache" ("dim_tache_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_performance_taches" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps" ("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_performance_techniciens"
(
    "fact_performance_techniciens_id" SERIAL PRIMARY KEY NOT NULL,
    "incident_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "incidents_resolved" INT,
    "total_incidents" INT,
    "resolution_rate" FLOAT, -- Ajout du taux de résolution des incidents (incidents_resolved / total_incidents)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_incident_fact_performance_techniciens" FOREIGN KEY ("incident_id") REFERENCES "dim_incident"("incident_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_performance_techniciens" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps"("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_gestion_poteaux"
(
    "fact_gestion_poteaux_id" SERIAL PRIMARY KEY NOT NULL,
    "dim_tache_id" INT NOT NULL,
    "dim_temps_id" INT NOT NULL,
    "coordination_time" FLOAT,
    "sla_met" BOOLEAN,
    "objective_time" FLOAT,
    "target_time" FLOAT,
    "sla_compliance_rate" FLOAT,   -- Taux de respect du SLA (coordination_time / sla_target)
    "rate" FLOAT,                  -- Taux calculé de respect du SLA
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_tache_fact_gestion_poteaux" FOREIGN KEY ("dim_tache_id") REFERENCES "dim_tache" ("dim_tache_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_temps_fact_gestion_poteaux" FOREIGN KEY ("dim_temps_id") REFERENCES "dim_temps" ("dim_temps_id") ON DELETE CASCADE
);

CREATE TABLE "fact_planification_interventions"
(
    "fact_planification_interventions_id" SERIAL PRIMARY KEY NOT NULL,  -- Clé primaire unique
    "task_id" INT,                   -- Identifiant de la tâche (référence à "dim_task")
    "date_id" INT,                   -- Référence à la date de planification (référence à "dim_time")
    "planning_time" FLOAT,           -- Temps nécessaire pour planifier l’intervention (en heures)
    "sla_met" BOOLEAN,               -- Si le délai de planification a respecté l’objectif (Vrai/Faux)
    "objective_time" FLOAT,          -- Temps cible fixé pour la planification (48h)
    "sla_compliance_rate" FLOAT,     -- Taux de respect du SLA (planning_time / target_time)
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP,
    "lb_job_name" VARCHAR(100),
    "bl_ligne_active" BOOLEAN,
    CONSTRAINT "fk_dim_task_fact_planification_interventions" FOREIGN KEY ("task_id") REFERENCES "dim_task" ("task_id") ON DELETE CASCADE,
    CONSTRAINT "fk_dim_time_fact_planification_interventions" FOREIGN KEY ("date_id") REFERENCES "dim_time" ("date_id") ON DELETE CASCADE
);

