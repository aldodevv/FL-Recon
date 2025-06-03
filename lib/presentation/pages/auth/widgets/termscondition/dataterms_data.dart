class TSectionData {
  final String key;
  final String title;
  final List<TStepData>? data;
  final String? text;

  TSectionData({required this.key, required this.title, this.data, this.text});
}

class TStepData {
  final int key;
  final String text;
  final List<TSubStepData>? subData;

  TStepData({required this.key, required this.text, this.subData});
}

class TSubStepData {
  final String key;
  final String text;

  TSubStepData({required this.key, required this.text});
}

final List<TSectionData> dataRender = [
  TSectionData(
    key: 'A',
    title: 'mobile.termsCondition.ATitle',
    data: [
      TStepData(key: 1, text: 'mobile.termsCondition.AText1'),
      TStepData(key: 2, text: 'mobile.termsCondition.AText2'),
      TStepData(key: 3, text: 'mobile.termsCondition.AText3'),
      TStepData(key: 4, text: 'mobile.termsCondition.AText4'),
    ],
  ),
  TSectionData(
    key: 'B',
    title: 'mobile.termsCondition.BTitle',
    data: [
      TStepData(key: 1, text: 'mobile.termsCondition.BText1'),
      TStepData(key: 2, text: 'mobile.termsCondition.BText2'),
      TStepData(
        key: 3,
        text: 'mobile.termsCondition.BText3',
        subData: [
          TSubStepData(key: 'a', text: 'mobile.termsCondition.BSubText3A'),
          TSubStepData(key: 'b', text: 'mobile.termsCondition.BSubText3B'),
          TSubStepData(key: 'c', text: 'mobile.termsCondition.BSubText3C'),
        ],
      ),
      TStepData(
        key: 4,
        text: 'mobile.termsCondition.BText4',
        subData: [
          TSubStepData(key: 'a', text: 'mobile.termsCondition.BSubText4A'),
          TSubStepData(key: 'b', text: 'mobile.termsCondition.BSubText4B'),
        ],
      ),
      TStepData(
        key: 5,
        text: 'mobile.termsCondition.BText5',
        subData: [
          TSubStepData(key: 'a', text: 'mobile.termsCondition.BSubTextA'),
          TSubStepData(key: 'b', text: 'mobile.termsCondition.BSubTextB'),
          TSubStepData(key: 'c', text: 'mobile.termsCondition.BSubTextC'),
          TSubStepData(key: 'd', text: 'mobile.termsCondition.BSubTextD'),
          TSubStepData(key: 'e', text: 'mobile.termsCondition.BSubTextE'),
        ],
      ),
      TStepData(key: 6, text: 'mobile.termsCondition.BText6'),
      TStepData(key: 7, text: 'mobile.termsCondition.BText7'),
      TStepData(key: 8, text: 'mobile.termsCondition.BText8'),
    ],
  ),
  TSectionData(
    key: 'C',
    title: 'mobile.termsCondition.CTitle',
    data: [
      TStepData(key: 1, text: 'mobile.termsCondition.CText1'),
      TStepData(key: 2, text: 'mobile.termsCondition.CText2'),
    ],
  ),
  TSectionData(
    key: 'D',
    title: 'mobile.termsCondition.DTitle',
    data: [
      TStepData(
        key: 1,
        text: 'mobile.termsCondition.DText1',
        subData: [
          TSubStepData(key: 'a', text: 'mobile.termsCondition.DSubTextA'),
          TSubStepData(key: 'b', text: 'mobile.termsCondition.DSubTextB'),
          TSubStepData(key: 'c', text: 'mobile.termsCondition.DSubTextC'),
        ],
      ),
      TStepData(key: 2, text: 'mobile.termsCondition.DText2'),
    ],
  ),
  TSectionData(
    key: 'E',
    title: 'mobile.termsCondition.ETitle',
    data: [
      TStepData(key: 1, text: 'mobile.termsCondition.EText1'),
      TStepData(key: 2, text: 'mobile.termsCondition.EText2'),
      TStepData(key: 3, text: 'mobile.termsCondition.EText3'),
    ],
  ),
  TSectionData(
    key: 'F',
    title: 'mobile.termsCondition.FTitle',
    text: 'mobile.termsCondition.FText',
  ),
  TSectionData(
    key: 'G',
    title: 'mobile.termsCondition.GTitle',
    data: [
      TStepData(key: 1, text: 'mobile.termsCondition.GText1'),
      TStepData(key: 2, text: 'mobile.termsCondition.GText2'),
      TStepData(key: 3, text: 'mobile.termsCondition.GText3'),
      TStepData(key: 4, text: 'mobile.termsCondition.GText4'),
    ],
  ),
];
