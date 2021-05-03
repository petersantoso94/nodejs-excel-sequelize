'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class input extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  };
  input.init({
    jumlah_koin: DataTypes.INTEGER,
    jenis_koin: DataTypes.INTEGER,
    Proses_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'input',
    timestamps: false,
    tableName: "input",
  });
  input.associate = function(models) {
    input.belongsTo(models.proses, {foreignKey: 'Proses_id', as: 'prosesInput'})
    input.belongsToMany(models.output, {through: 'pivot', foreignKey: 'Input_id', as: 'pivotsI'})
    input.hasMany(models.pivot, {
        foreignKey: {
          name: 'Input_id',
          allowNull: false
        },
        as : "inputPivot"
      })
  };
  return input;
};