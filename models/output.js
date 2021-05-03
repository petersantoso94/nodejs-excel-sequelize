"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class output extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  output.init(
    {
      jumlah_koin: DataTypes.INTEGER,
      Proses_id: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "output",
      tableName: "output",
      timestamps: false,
    }
  );
  output.associate = function (models) {
    output.belongsTo(models.proses, { foreignKey: "Proses_id", as: "proses" });
    output.belongsToMany(models.input, {
      through: "pivot",
      foreignKey: "Output_id",
      as: "pivots",
    });
  };
  return output;
};
