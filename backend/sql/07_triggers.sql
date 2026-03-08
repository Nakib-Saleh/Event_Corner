CREATE OR REPLACE FUNCTION update_events_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER events_updated_at
    BEFORE UPDATE ON events
    FOR EACH ROW
    EXECUTE FUNCTION update_events_timestamp();


CREATE TRIGGER timeslots_updated_at
    BEFORE UPDATE ON event_timeslots
    FOR EACH ROW
    EXECUTE FUNCTION update_events_timestamp();



CREATE TRIGGER registrations_updated_at
    BEFORE UPDATE ON event_registrations
    FOR EACH ROW
    EXECUTE FUNCTION update_events_timestamp();



-- DROP TRIGGER IF EXISTS events_updated_at ON events;
-- DROP TRIGGER IF EXISTS timeslots_updated_at ON event_timeslots;
-- DROP TRIGGER IF EXISTS registrations_updated_at ON event_registrations;
-- DROP FUNCTION IF EXISTS update_events_timestamp();
-- ============================================================================
