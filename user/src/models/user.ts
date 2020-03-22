import mongoose from 'mongoose';

const UserModel: mongoose.Model<mongoose.Document> = mongoose.model(
    'User',
    new mongoose.Schema({
        email: { type: String, required: true, unique: true, dropDups: true },
        username: { type: String, required: true, unique: true, dropDups: true },
        password: { type: String, required: true },
        fullName: { type: String, required: true },
        timeCreated: { type: Date, required: true, default: new Date() },
        dateOfBirth: { type: Date },
        location: { type: { type: mongoose.Types.ObjectId, ref: 'Location' } },
        token: { type: String },
    })
);

export { UserModel };
