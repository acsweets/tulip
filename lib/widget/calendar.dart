import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate = DateTime.now();

  List<Widget> _buildCalendarDays() {
    List<Widget> days = [];
    DateTime firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    int weekday = firstDayOfMonth.weekday - 1; // 这里修改了计算weekday的方式

    // 添加空白日期占位符
    for (int i = 0; i < weekday; i++) {
      days.add(Container(
        width: 40,
        height: 40,
        child: Text(''),
      ));
    }

    // 添加每一天
    int daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      bool isSelected = i == _selectedDate.day;
      DateTime date = DateTime(_selectedDate.year, _selectedDate.month, i);
      String weekdayName = DateFormat('EEE', 'zh_CN').format(date); // 这里使用'EEE'获取简写的星期名称
      days.add(GestureDetector(
        onTap: () {
          setState(() {
            _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, i);
          });
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$i',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              SizedBox(height: 2),
              Text(
                weekdayName,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ));
    }

    return days;
  }

  void _showMonthYearPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('选择月份和年份'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: _selectedDate.month,
                onChanged: (int? newMonth) {
                  if (newMonth != null) {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year, newMonth, _selectedDate.day);
                    });
                    Navigator.of(context).pop();
                  }
                },
                items: List.generate(12, (index) => index + 1).map((month) {
                  return DropdownMenuItem<int>(
                    value: month,
                    child: Text(DateFormat('MMMM', 'zh_CN').format(DateTime(2000, month, 1))),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              DropdownButton<int>(
                value: _selectedDate.year,
                onChanged: (int? newYear) {
                  if (newYear != null) {
                    setState(() {
                      _selectedDate = DateTime(newYear, _selectedDate.month, _selectedDate.day);
                    });
                    Navigator.of(context).pop();
                  }
                },
                items: List.generate(101, (index) => 2000 + index).map((year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text('$year'),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                });
              },
            ),
            GestureDetector(
              onTap: _showMonthYearPicker,
              child: Text(
                DateFormat('yyyy年M月', 'zh_CN').format(_selectedDate),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('一', style: TextStyle(color: Colors.grey)),
            Text('二', style: TextStyle(color: Colors.grey)),
            Text('三', style: TextStyle(color: Colors.grey)),
            Text('四', style: TextStyle(color: Colors.grey)),
            Text('五', style: TextStyle(color: Colors.grey)),
            Text('六', style: TextStyle(color: Colors.grey)),
            Text('日', style: TextStyle(color: Colors.grey)),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children: _buildCalendarDays(),
        ),
      ],
    );
  }
}