/ Create a connection to your Firebase database
Firebase ref = new Firebase("https://<YOUR-FIREBASE-APP>.firebaseio.com");
// Save data
ref.setValue("Alex Wolfe");
// Listen for realtime changes
ref.addValueEventListener(new ValueEventListener() {
    @Override
    public void onDataChange(DataSnapshot snap) {
        System.out.println(snap.getName() + " -> " + snap.getValue());
    }
    @Override public void onCancelled(FirebaseError error) { }
});