const models = require("../models/index");
var async = require("async");
const excel = require("exceljs");
const { Op } = require("sequelize");

const Proses = models.proses;
const Output = models.output;
const Pivot = models.pivot;
const Input = models.input;

// download report
exports.download = async function (req, res) {
  try {
    await Proses.findAll({
      include: [
        {
          model: Output,
          as: "output",
          include: {
            model: Input,
            as: "pivots",
            // include: {
            //   model: Pivot,
            //   as: "inputPivot",
            //   include: ["tally"],
            // },
          },
        },
      ],
    })
      .then((datas) => {
        console.log(JSON.stringify(datas));
        let workbook = new excel.Workbook();
        let worksheet = workbook.addWorksheet("Tutorials");
        worksheet.getCell("A1:F2").border = {
          top: { style: "thin" },
          left: { style: "thin" },
          bottom: { style: "thin" },
          right: { style: "thin" },
        };

        worksheet.getCell("A1:F2").alignment = {
          vertical: "middle",
          horizontal: "center",
        };
        worksheet.mergeCells("A1:A2");
        worksheet.mergeCells("B1:C1");
        worksheet.mergeCells("D1:F1");
        worksheet.mergeCells("G1:I2");
        worksheet.getCell("A1").value = "Proses";
        worksheet.getCell("B1").value = "Output";
        worksheet.getCell("D1").value = "Input";
        worksheet.getCell("G1").value = "Tally";
        worksheet.getCell("B2").value = "ID";
        worksheet.getCell("C2").value = "Jumlah Koin";
        worksheet.getCell("D2").value = "ID";
        worksheet.getCell("E2").value = "Jumlah Koin";
        worksheet.getCell("F2").value = "Jenis Koin";

        var row = 3;
        var rowOutput = 3;
        var rowPivot = 3;
        var rowTally = 3;
        datas.forEach((data) => {
          worksheet.getCell("A" + row).value = data.id;
          worksheet.mergeCells("A" + row + ":A" + (row + 11));
          
          data.output.forEach((outputs) => {
            worksheet.mergeCells("B" + rowOutput + ":B" + (rowOutput + 5));
            worksheet.mergeCells("C" + rowOutput + ":C" + (rowOutput + 5));
            worksheet.getCell("B" + rowOutput).value = outputs.id;
            worksheet.getCell("C" + rowOutput).value = outputs.jumlah_koin;
            rowOutput += 6;

            outputs.pivots.forEach((pivot) => {
              worksheet.mergeCells("D" + rowPivot + ":D" + (rowPivot + 1));
              worksheet.mergeCells("E" + rowPivot + ":E" + (rowPivot + 1));
              worksheet.mergeCells("F" + rowPivot + ":F" + (rowPivot + 1));
              worksheet.getCell("D" + rowPivot).value = pivot.id;
              worksheet.getCell("E" + rowPivot).value = pivot.jumlah_koin;
              worksheet.getCell("F" + rowPivot).value = pivot.jenis_koin;
              rowPivot += 2;
              Pivot.findAll({
                where: {
                  [Op.and]: [{ Output_id: outputs.id }, { Input_id: pivot.id }],
                },
                include: ["tally"],
              }).then((inputs) => {
                inputs.forEach((input) => {
                    typeof input.tally[0] !== "undefined"
                      ? console.log(input.tally[0].jumlah_koin)
                      : ""
                  worksheet.getCell("G" + rowTally).value =
                    typeof input.tally[0] !== "undefined"
                      ? input.tally[0].jumlah_koin
                      : "";
                  worksheet.getCell("H" + rowTally).value =
                    typeof input.tally[1] !== "undefined"
                      ? input.tally[1].jumlah_koin
                      : "";
                  worksheet.getCell("I" + rowTally).value =
                    typeof input.tally[2] !== "undefined"
                      ? input.tally[2].jumlah_koin
                      : "";
                  rowTally++;
                  worksheet.getCell("G" + rowTally).value =
                    typeof input.tally[3] !== "undefined"
                      ? input.tally[3].jumlah_koin
                      : "";
                  worksheet.getCell("H" + rowTally).value =
                    typeof input.tally[4] !== "undefined" 
                      ? input.tally[4].jumlah_koin
                      : "";
                  worksheet.getCell("I" + rowTally).value =
                    typeof input.tally[5] !== "undefined" 
                      ? input.tally[5].jumlah_koin
                      : "";
                  rowTally++;
                });
              });
            });
          });
          row += 12;
          rowOutput = row;
          rowPivot = row;
          rowTally = row;
        });
        res.setHeader(
          "Content-Type",
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        );
        res.setHeader(
          "Content-Disposition",
          "attachment; filename=" + "tutorials.xlsx"
        );
        return workbook.xlsx.write(res).then(function () {
          res.status(200).end();
        });
      })
      .catch((err) => {
        console.log("Error while find company : ", err);
      });
  } catch (err) {
    res.json({
      status: "ERROR",
      messages: err.message,
      data: {},
    });
  }
  //   async.parallel({
  //     book_count: function(callback) {
  //         omdb.search({api_url:api_url,api_key:api_key,params:params}, callback); // Pass an empty object as match condition to find all documents of this collection
  //     }
  // }, function(err, results) {
  //     console.log(results);
  //     res.render('index', { title: 'Local Library Home', error: err, data: results });
  // });
};
