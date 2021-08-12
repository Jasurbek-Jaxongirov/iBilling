import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/blocs/contracts/contracts_bloc.dart';
import '/data/models/contract.dart';
import '/presentation/ui/theme/app_constants.dart';
import 'package:jiffy/jiffy.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleContractItem extends StatefulWidget {
  final Contract contract;
  const SingleContractItem({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  _SingleContractItemState createState() => _SingleContractItemState();
}

class _SingleContractItemState extends State<SingleContractItem> {
  var isShow = false;

  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const text = 'Leave a comment, why are you deleting this contract?';
    return SizedBox(
      width: double.infinity,
      height: 370,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.62, vertical: 12),
            color: Constants.darkerColor,
            height: 310,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRichText(
                  labelText: '${'full-name'.tr()}: ',
                  infoText: widget.contract.fullName,
                ),
                CustomRichText(
                  labelText: '${'contract-status'.tr()}: ',
                  infoText: widget.contract.contractStatus.tr(),
                ),
                CustomRichText(
                  labelText: '${'amount'.tr()}: ',
                  infoText: widget.contract.amount.toString(),
                ),
                CustomRichText(
                  labelText: '${'last-invoice'.tr()}: ',
                  infoText: widget.contract.lastInvoice.toString(),
                ),
                CustomRichText(
                  labelText: '${'invoice-number'.tr()}: ',
                  infoText: widget.contract.invoiceAmount.toString(),
                ),
                CustomRichText(
                  labelText: '${'org-address'.tr()}: ',
                  infoText: widget.contract.address,
                ),
                CustomRichText(
                  labelText: '${'vatin'.tr()}: ',
                  infoText: widget.contract.organizationItn.toString(),
                ),
                CustomRichText(
                  labelText: 'Created at: ',
                  infoText: Jiffy(widget.contract.createdAt)
                      .format('h:mm, dd MMM, yyyy'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: MaterialButton(
              color: const Color(0xFFFF426D).withOpacity(0.3),
              minWidth: double.infinity,
              onPressed: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        backgroundColor: Constants.darkColor,
                        title: Text(
                          '$text',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        content: TextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          onChanged: (value) {
                            if (value == '') {
                              setState(() {
                                isShow = false;
                              });
                            } else {
                              setState(() {
                                isShow = true;
                              });
                            }
                            print(isShow);
                          },
                          controller: controller,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF5C5C5C),
                              hintText: 'Type here',
                              hintStyle: TextStyle(
                                color: Color(0xFFC0C0C0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: MediaQuery.of(ctx).size.width * 0.3),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) =>
                                                  const Color(0xFFFF426D)
                                                      .withOpacity(0.3))),
                                  onPressed: () {
                                    controller.clear();
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Color(0xFFFF426D)),
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: MediaQuery.of(ctx).size.width * 0.3),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) =>
                                                  const Color(0xFFFF426D))),
                                  onPressed: () {
                                    if (controller.text == '') {
                                      return;
                                    }

                                    Navigator.of(context).pop();
                                    BlocProvider.of<ContractsBloc>(context,
                                            listen: false)
                                        .setContractToDelete = widget.contract;

                                    BlocProvider.of<ContractsBloc>(context,
                                            listen: false)
                                        .deleteRequestedContract();
                                    BlocProvider.of<ContractsBloc>(context)
                                        .add(LoadContracts());
                                    controller.clear();
                                  },
                                  child: const Text('Done'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                'Delete Contract',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: const Color(0xFFFF426D)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String labelText;
  final String infoText;

  const CustomRichText(
      {Key? key, required this.labelText, required this.infoText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: labelText, children: [
        TextSpan(
          text: infoText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color(0xFF999999),
              ),
        ),
      ]),
    );
  }
}
