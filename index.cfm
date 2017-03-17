<cfoutput>

  <cfset _plugin = application.wheels.plugins.confirmerdisabler.init()>

	<h1>CFWheels Legacy Javascript Confirmer & Disabler V#_plugin.pluginVersion()#</h1>
	<h3>Re-instates removed <code>confirm</code> and <code>disable</code> arguments.</h3>

  <h3>Applies to:</h3>
  <ul>
    <li>buttonTag() : disable</li>
    <li>buttonTo() : confirm</li>
    <li>linkTo() : confirm</li>
    <li>submitTag() : disable</li>
  </ul>

	<h3>Usage:</h3>
	<pre>
  buttonTag(disable=true);

  buttonTo(confirm="Are you sure?");

  linkTo(confirm="Are you REALLY REALLY sure?");

  submitTag(disable=true);
</pre>

</cfoutput>
