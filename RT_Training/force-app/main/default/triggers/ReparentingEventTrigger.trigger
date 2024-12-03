trigger ReparentingEventTrigger on ReparentingRecord__e (after insert) {
        ReparentingEventHandler.handleReparenting(Trigger.new);
   
    }
    