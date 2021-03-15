import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.saveFilters, this.currentFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, bool value, Function update) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text('Only include ${title} meals'),
        onChanged: update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Drawer'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _vegetarian,
                  'vegan': _vegan,
                  'vegetarian': _lactoseFree
                };
                widget.saveFilters(selectedFilters);
              })
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust Meal Selection',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            _buildSwitchListTile('Gluten-Free', _glutenFree, (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            _buildSwitchListTile('Vegetarian', _vegetarian, (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            _buildSwitchListTile('Vegan', _vegan, (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
            _buildSwitchListTile('Lactose-Free', _lactoseFree, (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            })
          ],
        ))
      ]),
      drawer: MainDrawer(),
    );
  }
}
