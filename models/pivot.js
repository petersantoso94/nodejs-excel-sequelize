"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class pivot extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  pivot.init(
    {
      Input_id: DataTypes.INTEGER,
      Output_id: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "pivot",
      tableName: "pivot",
      timestamps: false,
    }
  );
  pivot.associate = function (models) {
    
    pivot.belongsTo(models.input, {foreignKey: 'Input_id', as: 'pivotInput'})
    pivot.belongsTo(models.output, {foreignKey: 'Output_id', as: 'pivotOutput'})
    pivot.hasMany(models.tally, {
        foreignKey: {
          name: 'Pivot_id',
          allowNull: false
        },
        as : "tally"
      })
  };
  return pivot;
};
