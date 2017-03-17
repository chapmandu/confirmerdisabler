component extends="wheels.Test" {

	function setup() {
		_controller = controller(name="dummy");
		oldURLRewriting = application.wheels.URLRewriting;
		application.wheels.URLRewriting = "On";
		oldScriptName = request.cgi.script_name;
		request.cgi.script_name = "/rewrite.cfm";
	}

	function teardown() {
		application.wheels.URLRewriting = oldURLRewriting;
		request.cgi.script_name = oldScriptName;
	}

	function test_ampersand_and_equals_sign_encoding() {
		actual = _controller.linkTo(text="x", controller="x", action="x", params="a=cats%26dogs%3Dtrouble&b=1");
		expected = '<a href="#application.wheels.webpath#x/x?a=cats%26dogs%3Dtrouble&amp;b=1">x</a>';
		assert('actual eq expected');
	}

	function test_controller_action_only() {
		actual = _controller.linkTo(text="Log Out", controller="account", action="logout");
		expected = '<a href="#application.wheels.webpath#account/logout">Log Out</a>';
		assert('actual eq expected');
	}

	function test_external_links() {
		actual = _controller.linkTo(href="http://www.cfwheels.com", text="CFWheels");
		expected = '<a href="http://www.cfwheels.com">CFWheels</a>';
		assert('actual eq expected');
	}

	function test_with_confirm() {
		actual = _controller.linkTo(href="/", text="foo", confirm="Are you sure?");
		expected = '<a href="/" onclick="return confirm(''Are you sure?'');">foo</a>';
		assert('actual eq expected');
	}

}
