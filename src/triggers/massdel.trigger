trigger massdel on Account (after insert, after update) {

    String query = 'SELECT id, name FROM Account WHERE OwnerId = \'00590000000zui5\'';
    MassDeleteRecords batchApex = new MassDeleteRecords(query );
    ID batchprocessid = Database.executeBatch(batchApex);
}