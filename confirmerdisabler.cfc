component output="false" {

	public any function init() {
		this.version = "2.0";
		return this;
	}

  public string function pluginVersion() {
    return "0.1.0";
  }

  public string function buttonTag(
    string content,
    string type,
    string value,
    string image,
    any disable,
    string prepend,
    string append
  ) {
    $args(name="buttonTag", args=arguments);

    // add onclick attribute to disable the form button
    if (Len(arguments.disable)) {
      local.onclick = "this.disabled=true;";
      if (!Len(arguments.image) && !IsBoolean(arguments.disable)) {
        local.onclick &= "this.value='#JSStringFormat(arguments.disable)#';";
      }
      local.onclick &= "this.form.submit();";
      arguments.onclick = $addToJavaScriptAttribute(name="onclick", content=local.onclick, attributes=arguments);
    }

    // if image is specified then use that as the content
    if (Len(arguments.image)) {
      local.args = {};
      local.args.type = "image";
      local.args.source = arguments.image;
      arguments.content = imageTag(argumentCollection=local.args);
    }

    // save necessary info from arguments and delete afterwards
    local.content = arguments.content;
    local.prepend = arguments.prepend;
    local.append = arguments.append;
    StructDelete(arguments, "content");
    StructDelete(arguments, "image");
    StructDelete(arguments, "disable");
    StructDelete(arguments, "prepend");
    StructDelete(arguments, "append");

    // create the button
    return local.prepend & $element(name="button", content=local.content, attributes=arguments) & local.append;
  }

  public string function buttonTo(
    string text,
    string confirm,
    string image,
    any disable,
    string route="",
    string controller="",
    string action="",
    any key="",
    string params="",
    string anchor="",
    boolean onlyPath,
    string host,
    string protocol,
    numeric port
  ) {
    $args(name="buttonTo", reserved="method", args=arguments);
    arguments.action = URLFor(argumentCollection=arguments);
    arguments.action = toXHTML(arguments.action);
    arguments.method = "post";
    if (Len(arguments.confirm)) {
      local.onsubmit = "return confirm('#JSStringFormat(arguments.confirm)#');";
      arguments.onsubmit = $addToJavaScriptAttribute(name="onsubmit", content=local.onsubmit, attributes=arguments);
    }
    local.args = $innerArgs(name="input", args=arguments);
    local.args.value = arguments.text;
    local.args.image = arguments.image;
    local.args.disable = arguments.disable;
    local.content = submitTag(argumentCollection=local.args);
    local.skip = "disable,image,text,confirm,route,controller,key,params,anchor,onlyPath,host,protocol,port";
    if (Len(arguments.route)) {
      // variables passed in as route arguments should not be added to the html element
      local.skip = ListAppend(local.skip, $routeVariables(argumentCollection=arguments));
    }
    return $element(name="form", skip=local.skip, content=local.content, attributes=arguments);
  }

  public string function linkTo(
    string text,
    string confirm="",
    string route="",
    string controller="",
    string action="",
    any key="",
    string params="",
    string anchor="",
    boolean onlyPath,
    string host,
    string protocol,
    numeric port,
    string href
  ) {
    $args(name="linkTo", args=arguments);
		if (Len(arguments.confirm))
		{
			local.onclick = "return confirm('#JSStringFormat(arguments.confirm)#');";
			arguments.onclick = $addToJavaScriptAttribute(name="onclick", content=local.onclick, attributes=arguments);
		}
		if (!StructKeyExists(arguments, "href"))
		{
			arguments.href = URLFor(argumentCollection=arguments);
		}
		arguments.href = toXHTML(arguments.href);
		if (!StructKeyExists(arguments, "text"))
		{
			arguments.text = arguments.href;
		}
		local.skip = "text,confirm,route,controller,action,key,params,anchor,onlyPath,host,protocol,port";
		if (Len(arguments.route))
		{
			// variables passed in as route arguments should not be added to the html element
			local.skip = ListAppend(local.skip, $routeVariables(argumentCollection=arguments));
		}
		return $element(name="a", skip=local.skip, content=arguments.text, attributes=arguments);
  }

  public string function submitTag(
    string value,
    string image,
    any disable,
    string prepend,
    string append
  ) {
    $args(name="submitTag", reserved="type,src", args=arguments);
    local.rv = arguments.prepend;
    local.append = arguments.append;
    if (StructKeyExists(arguments, "disable") && Len(arguments.disable)) {
      local.onclick = "this.disabled=true;";
      if (!Len(arguments.image) && !IsBoolean(arguments.disable)) {
        local.onclick &= "this.value='#JSStringFormat(arguments.disable)#';";
      }
      local.onclick &= "this.form.submit();";
      arguments.onclick = $addToJavaScriptAttribute(name="onclick", content=local.onclick, attributes=arguments);
    }
    if (Len(arguments.image)) {
      // create an img tag and then just replace "img" with "input"
      arguments.type = "image";
      arguments.source = arguments.image;
      StructDelete(arguments, "value");
      StructDelete(arguments, "image");
      StructDelete(arguments, "disable");
      StructDelete(arguments, "append");
      StructDelete(arguments, "prepend");
      local.rv &= imageTag(argumentCollection=arguments);
      local.rv = Replace(local.rv, "<img", "<input");
    } else {
      arguments.type = "submit";
      local.rv &= $tag(name="input", close=true, skip="image,disable,append,prepend", attributes=arguments);
    }
    local.rv &= local.append;
    return local.rv;
  }

  public string function $addToJavaScriptAttribute(
    required string name,
    required string content,
    required struct attributes
  ) {
    if (StructKeyExists(arguments.attributes, arguments.name)) {
      local.rv = arguments.attributes[arguments.name];
      if (Right(local.rv, 1) != ";") {
        local.rv &= ";";
      }
      local.rv &= arguments.content;
    } else {
      local.rv = arguments.content;
    }
    return local.rv;
  }

}
