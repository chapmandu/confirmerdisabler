component extends="wheels.Test" {

	function setup() {
		_controller = controller(name="Foo");
	}

	function test_defaults() {
		actual = _controller.submitTag();
		expected = '<input type="submit" value="Save changes" />';
		assert('actual eq expected');
	}

	function test_disabled_is_escaped() {
		actual = _controller.submitTag(disable="Mark as: 'Completed'?");
		expected = '<input onclick="this.disabled=true;this.value=''Mark as: \''Completed\''?'';this.form.submit();" type="submit" value="Save changes" />';
		assert('actual eq expected');
	}

	function test_append_prepend() {
		actual = _controller.submitTag(append="a", prepend="p");
		expected = 'p<input type="submit" value="Save changes" />a';
		assert('actual eq expected');
	}

}
