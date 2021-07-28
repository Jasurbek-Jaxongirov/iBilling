import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_billing/api/mock_ibilling_service.dart';
import 'package:i_billing/models/contract.dart';
import 'package:i_billing/ui/android/components/calendar.dart';
import 'package:i_billing/ui/theme/app_constants.dart';

import 'components/contract_item.dart';

class ContractsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Constants.darkestColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.25,
            child: CustomCalendar(),
          ),
          Expanded(
            child: FutureBuilder(
              future: MockIBillingService().getContractResponse(),
              builder: (ctx, snapshot) {
                if (snapshot.error == null) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data as List<Contract>;
                    print(snapshot.error);
                    if (data.length == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/empty-contracts.svg'),
                          SizedBox(
                            height: mediaQuery.size.height * 0.05,
                          ),
                          Text(
                            'No contracts are made',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      );
                    }
                    print('Worked');

                    print(data.length);
                    return Scrollbar(
                      showTrackOnHover: true,
                      isAlwaysShown: true,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: ContractItem(
                            contractStatus: data[index].contractStatus,
                            lastInvoice: data[index].lastInvoice,
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  print(snapshot.error);

                  print('Failed to work');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'An error has occurred!',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.05,
                      ),
                      Text(
                        'Sorry! Internal error has occured!',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
