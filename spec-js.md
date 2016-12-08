# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
<!-- jquery-rails gem installed and jquery required in manifest -->
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
<!--
  Prior plan details are fetched and rendered in a modal via jQuery/AJAX get request. A click event is bound to the modal's
  trigger button that makes an AJAX GET request to "/plans/id.json". I then pull the plan's date (after "prettifying"
  it) along with the id, price and name of each of its purchases. The elements are then structured and injected into the
  modal. The process is repeated when the user clicks on the modal's "Previous" button until there are no prior months
  to render.
-->
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
<!--
  A User has many payments. A user's list of payments can be viewed in the user edit view (kind of a strange
  place, I know). A click event is bound to the "PaymentS" button that makes an AJAX GET request to "/payments".
  The backend renders the payments in JSON format, the list of payments is parsed and then set to replace `div.well`
  in the DOM.
-->
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
<!--
  A plan has many users and has many purchases. A user has many payments. AMS is used to serialize Plan, User and
  Payment resources. As mentioned above, both purchases and payments are both rendered via JSON and injected
  into the DOM.
-->
- [x] Include at least one link that loads or updates a resource without reloading the page.
<!--
  Users can add planned purchases to their plans without reloading the page. The purchase resource is serialized,
  submitted via AJAX POST request, the response is a new JSON object that is translated into a js model object and
  then then appended to the DOM (with the help of Handlebars).
-->
- [x] Translate JSON responses into js model objects.
<!--
  I use `class Purchase` to translate new purchases being added to a plan (see above) to js model objects. The properties
  of each Purchase are id, price and item. I used an ES6 class because it's cleaner, IMO.
-->
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
<!--
  Within `class Purchase` is the method `renderLi()` that returns the li element structured in the Handlebars template, which
  is later appended to the DOM.
-->

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
