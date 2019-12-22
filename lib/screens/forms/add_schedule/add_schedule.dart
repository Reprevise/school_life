import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:school_life/blocs/blocs.dart';
import 'package:school_life/screens/forms/widgets/page_navigator.dart';
import 'package:school_life/components/index.dart';

final PageController _controller = PageController();

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  AddScheduleFormBloc _formBloc;

  @override
  void dispose() {
    _formBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        "Add Schedule",
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      drawer: CustomDrawer(),
      body: BlocProvider<AddScheduleFormBloc>(
        builder: (context) => AddScheduleFormBloc(),
        child: Builder(builder: (context) {
          _formBloc = BlocProvider.of<AddScheduleFormBloc>(context);
          return FormBlocListener<AddScheduleFormBloc, String, dynamic>(
            onSuccess: (context, state) {
              Navigator.of(context).pushNamed("/schedule");
            },
            child: BlocBuilder<AddScheduleFormBloc, FormBlocState>(
              builder: (context, state) {
                if (state is FormBlocLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FormBlocLoadFailed) {
                  return Center(child: Text("Uh oh! Try again later"));
                } else {
                  return PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _FirstPage(_formBloc),
                      _SecondPage(_formBloc),
                      _ThirdPage(_formBloc),
                    ],
                  );
                }
              },
            ),
          );
        }),
      ),
    );
  }
}

class _FirstPage extends StatefulWidget {
  final AddScheduleFormBloc formBloc;

  _FirstPage(this.formBloc);

  @override
  __FirstPageState createState() => __FirstPageState();
}

class __FirstPageState extends State<_FirstPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    num cWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What subject do you want to create a schedule for?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: DropdownFieldBlocBuilder(
                selectFieldBloc: widget.formBloc.subjectField,
                millisecondsForShowDropdownItemsWhenKeyboardIsOpen: 100,
                itemBuilder: (context, value) => value,
                showEmptyItem: false,
                decoration: InputDecoration(
                  labelText: "Subject",
                  prefixIcon: Icon(
                    Icons.subject,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                color: Colors.blue[800],
                textColor: Colors.white,
                child: const Text("Next"),
                onPressed: () {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(15),
                    right: Radius.circular(15),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SecondPage extends StatefulWidget {
  final AddScheduleFormBloc formBloc;

  _SecondPage(this.formBloc);

  @override
  __SecondPageState createState() => __SecondPageState();
}

class __SecondPageState extends State<_SecondPage>
    with AutomaticKeepAliveClientMixin<_SecondPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    num cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What days do you have this subject on?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: CheckboxGroupFieldBlocBuilder<String>(
                multiSelectFieldBloc: widget.formBloc.scheduleDaysField,
                itemBuilder: (context, value) => value,
                decoration: InputDecoration(
                  labelText: "Days",
                  prefixIcon: Icon(
                    Icons.view_day,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ),
        PageNavigator(_controller),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ThirdPage extends StatefulWidget {
  final AddScheduleFormBloc formBloc;

  _ThirdPage(this.formBloc);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<_ThirdPage>
    with AutomaticKeepAliveClientMixin<_ThirdPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    num cWidth = MediaQuery.of(context).size.width * 0.8;
    return Column(
      children: <Widget>[
        Container(
          width: cWidth,
          child: Text(
            "What times do you have this subject?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // TODO start and end times here
              ],
            ),
          ),
        ),
        PageNavigator(_controller),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
