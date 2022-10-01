import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app_constants/app_constants.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/repositories/repositories.dart';
import 'package:news_app/services/exceptions/exceptions.dart';
import 'package:news_app/widgets/widgets.dart';

class CountrySpecificHeadlinesPage extends StatefulWidget {
  const CountrySpecificHeadlinesPage({Key? key}) : super(key: key);

  @override
  State<CountrySpecificHeadlinesPage> createState() => _CountrySpecificHeadlinesPageState();
}

class _CountrySpecificHeadlinesPageState extends State<CountrySpecificHeadlinesPage> {
  late final NewsRepository newsRepository;
  late Future<List<Article>?> futureHeadlines;

  @override
  void initState() {
    super.initState();

    newsRepository = NewsRepository();
    futureHeadlines = newsRepository.getHeadlinesFromCountry('us'); // Default: US
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    countryFilter: AppStrings.headlineSourceCountryCodes,
                    showPhoneCode: false,
                    onSelect: (Country c) {
                      setState(() {
                        futureHeadlines = newsRepository.getHeadlinesFromCountry(c.countryCode.toLowerCase());
                      });
                    },
                  );
                },
                child: Text(
                  AppStrings.chooseASourceText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                AppStrings.defaultSourcePageInfoMessage,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: futureHeadlines,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasData) {
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Text(
                                AppStrings.headlinesListIsEmptyText,
                                style: Theme.of(context).primaryTextTheme.headline2,
                              ),
                            )
                          : ArticleListTileListView(articles: snapshot.data!);
                    } else if (snapshot.hasError) {
                      final errorMessage = snapshot.error is HttpException
                          ? snapshot.error.toString()
                          : AppStrings.headlinesListIsEmptyText;
                      return Center(
                        child: Text(
                          '❌ $errorMessage ❌',
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          AppStrings.headlinesListIsEmptyText,
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
