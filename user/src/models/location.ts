import mongoose from 'mongoose';

const LocationModel: mongoose.Model<mongoose.Document> = mongoose.model(
    'Location',
    new mongoose.Schema({
        city: {
            type: String,
            required: true,
        },
        province: {
            type: String,
            maxlength: 2,
            required: true,
        },
        country: {
            type: String,
            required: true,
        },
    }).index({ city: 1, country: 1 }, { unique: true })
);

export { LocationModel };
