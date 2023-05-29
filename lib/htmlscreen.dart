import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


const htmlData = r"""
<!DOCTYPE html>
<html>
<body>

<h2>JavaScript Alert</h2>

<button onclick="myFunction()">Try it</button>

<script>
function myFunction() {
  alert("I am an alert box!");
}
</script>

</body>
</html>
      """;
class HtmlPage extends StatefulWidget {
  const HtmlPage({Key? key}) : super(key: key);

  @override
  State<HtmlPage> createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Html(data: htmlData, tagsList: Html.tags..addAll(['button','script']),),
    ));
  }
}
